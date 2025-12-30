# auth.py
import hashlib
import time
from validation import validate_password
from user import User, UserStorage
from passlib.context import CryptContext

pw_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def register_user(storage: UserStorage, username: str, email: str, password: str) -> User:
    """
    Создает пользователя и сохраняет хэш пароля в виде bcrypt.
    """
    if User.exists(storage, username):
        raise ValueError("Пользователь с таким username уже существует")

    validate_password(password)

    bcrypt_hash = pw_context.hash(password)
    user = User(username=username, email=email, password_hash=bcrypt_hash)
    user.save(storage)
    return user

def load_user(storage: UserStorage, username: str):
    
    return User.load(storage, username)

def update_user(storage: UserStorage, username: str, **updates):
    user = load_user(storage, username)
    
    if user is None:
        return
    for key, value in updates.items():
        setattr(user, key, value)
        
    user.save(storage)

def is_legacy_md5(hash_value: str) -> bool:
    return len(hash_value) == 32 and all(c in "0123456789abcdefABCDEF" for c in hash_value)

def increment_failed_attempts(storage: UserStorage, username: str):
    user = load_user(storage, username)
    if user is None:
        return
    current = getattr(user, "failed_pw_attempts", 0)
    count = current + 1
    update_user(
        storage,
        username,
        failed_pw_attempts = count,
        locked = (count >= 5),
    )

def reset_failed_attempts(storage: UserStorage, username: str):
    update_user(
        storage,
        username,
        failed_pw_attempts = 0,
        locked = False,
    )
    
def is_account_locked(storage: UserStorage, username: str) -> bool:
    user = load_user(storage, username)
    return user is not None and getattr(user, "locked", False)

def verify_credentials(storage: UserStorage, username: str, password: str) -> bool:
    """
    Возвращает True, если пользователь существует и bcrypt(password) совпадает с сохраненным.
    """
    user = User.load(storage, username)
    if user is None:
        return False
    
    if getattr(user, "locked", False):
        return False
    
    current_hash = user.password_hash
    correct = False
    
    if is_legacy_md5(current_hash):
        candidate = hashlib.md5(password.encode("utf-8")).hexdigest()
        correct = (candidate == current_hash)
    else:
        correct = pw_context.verify(password, current_hash)
        
    if correct:
        if is_legacy_md5(current_hash):
            new_hash = pw_context.hash(password)
            update_user(
                storage,
                username,
                password_hash = new_hash,
                failed_attempts = 0,
                locked = False,
            )
        else:
            reset_failed_attempts(storage, username)
        return True
    else:
        increment_failed_attempts(storage, username)
        return False