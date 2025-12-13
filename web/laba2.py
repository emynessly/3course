class Exhibit:
    def __init__(self, id, title, author):
        self.id: int = id
        self.title: str = title
        self.author: str = author
        
    def __str__(self) -> str:
        return f'Номер экспоната: {self.id}, название: {self.title}, автор: {self.author}'
    
class Hall:
    def __init__(self, name, size):
        self.name: str = name
        self.size: float = size
        self.exhibits: list[Exhibit] = []

    def add_exhibit(self, exhibit: Exhibit) -> None:
        self.exhibits.append(exhibit)
        
    def __str__(self) -> str:
        return f'{self.name}, размер зала: {self.size} м², экспонаты:'
    
class Museum:
    def __init__(self, name, area):
        self.name: str = name
        self.area: float = area
        self.halls: list[Hall] = []

    def add_hall(self, hall) -> None:
        self.halls.append(hall)

    def description(self) -> str:
            lines = [f"Музей: {self.name} \n Площадь: {self.area} м² \n Залы:"]
            for hall in self.halls:
                lines.append(f"{hall}")
                for exhibit in hall.exhibits:
                    lines.append(f" {exhibit}")
            return "\n".join(lines)

    def __str__(self) -> str:
        return self.name
    
def main():
    h1 = Hall("Реализм", 200.0)
    h2 = Hall("Импрессионизм", 100.0)
    
    h1.add_exhibit(Exhibit(1, "Шелест берёз", "Тихомиров Леонид"))
    h1.add_exhibit(Exhibit(2, "Подмосковье", "Коновалов Юрий"))
    
    h2.add_exhibit(Exhibit(3, "Горячие цветы", "Чепик Мария"))
    h2.add_exhibit(Exhibit(4, "Цветочный вальс", "Меркулова София"))
    
    m1 = Museum("Музей живописи", 400.0)
    m1.add_hall(h1)
    m1.add_hall(h2)
      
    print(m1.description())
    
if __name__ == '__main__':
    main()
