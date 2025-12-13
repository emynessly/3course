DISABLED = False

def disabled_if_flag(func):
    def wrapper(*args, **kwargs):
        if DISABLED:
            raise RuntimeError("Feature disabled")
        return func(*args, **kwargs)
    return wrapper
@disabled_if_flag
def work():
    return "done"

print(work())   # done

DISABLED = True
print(work())   # RuntimeError: Feature disabled
