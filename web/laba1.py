class Phone:
    # Члены класса
    # 1. Поля
    def __init__(self, brand, serial_number, battery):
        self.brand: str = brand
        self.serial_number: str = serial_number
        self.battery: str = battery
    
    # 2. Методы    
    def charge(self):
        charging = int(self.battery)
        while charging < 100:
            charging += 2
            if charging > 99:
                print(f'Ваш {self.brand} полностью заряжен')
                charging = 100
                break
            else:
                print(f'Ваш {self.brand} заряжен на {charging}%')
        self.battery = str(charging)

    def __str__(self) -> str:
        return f'{self.brand}: {self.serial_number}, {self.battery}'


def main():
    f1 = Phone('iPhone', 'MVMQ62H3Y', '55')    
    f1.charge()
    print(f1)
    
if __name__ == '__main__':
    main()
