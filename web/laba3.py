class Employee:
    def __init__(self, name, salary):
        self.name = name
        self.salary = salary

    def calculate_bonus(self):
        return self.salary * 0.10
    
    def __str__(self):
        return f'Сотрудник {self.name} с зарплатой в {self.salary} рублей получит премию в размере {self.calculate_bonus()} рублей.'        
        
class Manager(Employee):
    def __init__(self, name, salary, management_level):
        super().__init__(name, salary)
        self.management_level = management_level
    
    def calculate_bonus(self):
        bonus = super().calculate_bonus()
        if self.management_level > 3:
            bonus += self.salary * 0.05
        return bonus
    
    def __str__(self):
        return f'Менеджер {self.name}, имея уровень руководства {self.management_level}, с зарплатой в {self.salary} рублей получит премию в размере {self.calculate_bonus()} рублей.'
    
class Developer(Employee):
    def __init__(self, name, salary, know_javascript):
        super().__init__(name, salary)
        self.know_javascript = know_javascript
        
    def calculate_bonus(self):
        bonus = super().calculate_bonus()
        if self.know_javascript:
            bonus += self.salary * 0.03
        return bonus
    
    def __str__(self):
        if self.know_javascript:
            js_status = "да"
        else: "нет"
        return f'Разработчик {self.name}, знает JavaScript: {self.know_javascript}, с зарплатой в {self.salary} рублей получит премию в размере {self.calculate_bonus()} рублей.'


if __name__ == '__main__':
    print()
    
    employee1 = Employee("Екатерина Зайцева", 60000)
    
    manager1 = Manager("Марина Лукина", 90000, 4)
    manager2 = Manager("Александр Волков", 90000, 3)

    developer1 = Developer("Максим Рунин", 70000, True)
    developer2 = Developer("Софья Мунина", 70000, False)
    
    print(f"Менеджер уровня 4: {manager1.name}")
    print(f" Зарплата: {manager1.salary} рублей")
    print(f" Премия в размере {manager1.calculate_bonus()} рублей")
    print()
    
    print(f"Разработчик, владеющий JavaScript: {developer1.name}")
    print(f" Зарплата: {developer1.salary} рублей")
    print(f" Премия в размере {developer1.calculate_bonus()} рублей")
    print()
    
    print(f"Менеджер уровня 3: {manager2.name}")
    print(f" Зарплата: {manager2.salary} рублей")
    print(f" Премия в размере {manager2.calculate_bonus()} рублей")
    print()
    
    print(f"Разработчик, не владеющий JavaScript: {developer2.name}")
    print(f" Зарплата: {developer2.salary} рублей")
    print(f" Премия в размере {developer2.calculate_bonus()} рублей")
    