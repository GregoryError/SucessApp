#include "pch.h"
#include "Wine.h"




Wine::Wine(const char* l, const int y, const int yr[], const int bot[])
{
	label = l;
	years = y;
	data.first().resize(years);
	data.second().resize(years);
	for (int i = 0; i < years; ++i)
	{
		data.first()[i] = yr[i];
		data.second()[i] = bot[i];
	}

}


void Wine::GetBottles()
{
	for (int i = 0; i < years; ++i)
	{
		std::cout << "Enter " << (i + 1) << " year: ";
		std::cin >> data.first()[i];
		std::cout << "How many bottles: ";
		std::cin >> data.second()[i];
	}
	
}


void Wine::Show()
{
	std::cout << "The label:" << label << "\n";
	std::cout << "The number of years: " << years << "\n";
	std::cout << std::endl;
	std::cout << std::endl;
	for (int i = 0; i < years; ++i)
	{
		std::cout << "Year: " << data.first()[i] << "; Bottles: " << data.second()[i] << std::endl;
	}
}

Wine::~Wine()
{
}
