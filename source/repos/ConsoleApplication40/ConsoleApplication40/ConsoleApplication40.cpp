// ConsoleApplication40.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>
#include "port.h"


using namespace std;


int main()
{
	cout << "Enter the size of collection: ";
	int size;
	cin >> size;

	Port **collection = new Port*[size];

	for (int i = 0; i < size; ++i)
	{
		cout << "Enter the type of port(1 - for classic; 2 - for Vintage): ";
		char answ;
		while (cin >> answ && (answ != '1' && answ != '2'))
			cout << "Please, enter ether 1 or 2!\n";
		cin.get();

		if (answ == '1')
		{
			cout << "The classic port creation: \n";
			cout << "Enter the brand: ";
			char brnd[30];
			cin.getline(brnd, 30);
			cout << "Enter the style: ";
			char sty[20];
			cin.getline(sty, 20);
			cout << "Enter quantity of  bottles: ";
			int bq;
			cin >> bq;
			collection[i] = new Port(brnd, sty, bq);
		}

		if (answ == '2')
		{
			cout << "The vintage port creation: \n";
			cout << "Enter the brand: ";
			char brnd[30];
			cin.getline(brnd, 30);
			cout << "Enter the nickname: ";
			char Nn[30];
			cin.getline(Nn, 20);
			cout << "Enter quantity of  bottles: ";
			int bq;
			cin >> bq;
			cout << "Enter the year: ";
			int yy;
			cin >> yy;
			collection[i] = new VintagePort(brnd, bq, Nn, yy);
		}

	}


	cout << "\n\n\nThe collection was made:\n";

	for (int i = 0; i < size; ++i)
	{
		cout << "Item #" << i + 1 << ":\n\n";
		collection[i]->Show();
	}

	for (int i = 0; i < size; ++i)
	{
		delete[] collection[i];
	}

	delete[] collection;


	system("pause");
	return 0;
}

