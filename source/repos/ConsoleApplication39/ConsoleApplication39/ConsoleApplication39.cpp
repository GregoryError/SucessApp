// ConsoleApplication39.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include "pch.h"
#include <iostream>
#include "dma.h"

const int MAX_COUNT = 4;

int main()
{
   
	baseDMA* arr[MAX_COUNT];

	std::cout << "Enter the type of object (1 for lackDMA, 2 for hasDMA):\n";

	char ans;

	for (int i = 0; i < MAX_COUNT; ++i)
	{
		while (std::cin >> ans && (ans != '1' && ans != '2'))
			std::cout << "Enter ether 1 or 2!\n";
		if (ans == '1')
		{		
			std::cout << "Enter data for lackDMA object: " << std::endl;
			std::cin.get();
			std::cout << "Enter color: ";
			char str[81];
			std::cin.getline(str, 81);
			std::cout << std::endl;

			std::cout << "Enter label: ";
			char lbl[81];
			std::cin.getline(lbl, 81);
			std::cout << std::endl;

			std::cout << "Enter rating: ";
			int rtg;
			std::cin >> rtg;
			std::cout << std::endl;

			arr[i] = new lacksDMA(str, lbl, rtg);

			std::cout << "Thanks.\n";
		}


		if (ans == '2')
		{
			std::cout << "Enter data for hasDMA object: " << std::endl;
			std::cin.get();
			std::cout << "Enter style: ";
			char str[81];
			std::cin.getline(str, 81);
			std::cout << std::endl;

			std::cout << "Enter label: ";
			char lbl[81];
			std::cin.getline(lbl, 81);
			std::cout << std::endl;

			std::cout << "Enter rating: ";
			int rtg;
			std::cin >> rtg;
			std::cout << std::endl;

			arr[i] = new hasDMA(str, lbl, rtg);

			std::cout << "Thanks.\n";
		}

		std::cout << "Enter the type of object (1 for lackDMA, 2 for hasDMA):\n";
	}



	std::cout << std::endl;
	std::cout << "All objects was created!\n";


	for (int i = 0; i < MAX_COUNT; ++i)
	{
		std::cout << "Object #" << i << ":\n";
		arr[i]->view();
	}

	for (int i = 0; i < MAX_COUNT; ++i)
	{
		delete[] arr[i];
	}


	system("pause");
	return 0;
}

// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.
