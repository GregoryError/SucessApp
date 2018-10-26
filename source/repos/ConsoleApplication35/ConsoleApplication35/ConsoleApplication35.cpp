// ConsoleApplication35.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>
#include "Stack.h"

using namespace std;

int main()
{

	Stack first;

	Stack second(7);

	

	for (int i = 0; i < 10; ++i)
	{
		cout << "Pushing " << i << " element: " << second.push((i + 1) * 12) <<  " Val: " << (i + 1) * 12 << '\n';
	}


	first = second;

	cout << "The elements of the Stack:\n";

	for (int i = 0; i < 15; ++i)
	{
		cout << "Trying read element #" << i << ": ";
		unsigned long el;
		if (second.pop(el))
			cout << el << '\n';
		else
			cout << "the element # " << i << " doesnt exist!\n";
	}


	cout << "Now readint first Stack:\n";

	for (int i = 0; i < 15; ++i)
	{
		cout << "Trying read element #" << i << ": ";
		unsigned long el;
		if (first.pop(el))
			cout << el << '\n';
		else
			cout << "the element # " << i << " doesnt exist!\n";
	}

  
	system("pause");
	return 0;
}
