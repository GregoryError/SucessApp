// ConsoleApplication34.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>
#include "stpck20.h"

const int STKS = 4;

int main()
{
	Stock stocks[STKS] = {
	Stock("NanoSmart", 12, 20.0),
	Stock("Boffo Objects", 200, 2.0),
	Stock("Monolitic Obeliscs", 130, 3.25),
	Stock("Fleep Enterprises", 60, 6.5)
	};

	std::cout << "Stock holdings:\n";
	int st;
	for (st = 0; st < STKS; st++)
	{
		std::cout << stocks[st];
	}



	system("pause");
	return 0;
}

