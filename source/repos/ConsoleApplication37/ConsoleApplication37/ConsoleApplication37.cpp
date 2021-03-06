// ConsoleApplication37.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>
#include "classic.h"

void Bravo(const cd &disk);

int main()
{
	cd c1("Beatles", "Capitol", 14, 35.5);
	classic c2 = classic("Piano Sonata in B flat, Fantasia in C",
		"Alfred Brendel", "Philips", 2, 57.17);
	cd *pcd = &c1;
	
	std::cout << "Using objects directly:\n";
	c1.Report();
	c2.Report();
	
	std::cout << "Using pointer to objects (*pcd):\n";
	pcd->Report();
	pcd = &c2;
	pcd->Report();
	
	std::cout << "Calling a function with a cd reference argument:\n";
	Bravo(c1);
	Bravo(c2);
	
	std::cout << "Testing assignment:\n";
	classic copy;
	copy = c2;
	copy.Report();

	
	system("pause");
	return 0;
}

void Bravo(const cd &disk)
{
	disk.Report();
}
