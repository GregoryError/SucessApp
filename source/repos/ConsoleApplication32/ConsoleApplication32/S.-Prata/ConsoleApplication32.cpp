// ConsoleApplication32.cpp: определяет точку входа для консольного приложения.
//

#include "stdafx.h"
#include "cow.h"

int main()
{
	Cow empty;
	std::cout << "An empty:\n";
	empty.ShowCow();

	Cow some("Masha", "Eating grass", 80.7);
	std::cout << "Some cow:\n";
	some.ShowCow();

	empty = some;
	
	std::cout << "empty = some:\n";
	empty.ShowCow();
	
	
	Cow another(empty);
	std::cout << "Cow another(empty):\n";
	another.ShowCow();
	
	

	system("pause");
    return 0;
}

