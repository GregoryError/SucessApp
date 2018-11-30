#include "pch.h"
#include "emp.h"


abstr_emp::~abstr_emp()
{

}

void abstr_emp::SetAll()
{
	std::cout << "Enter the firstname: ";
	std::cin >> fname;
	std::cout << "Enter the lastname: ";
	std::cin >> lname;
	std::cout << "Enter the job: ";
	std::cin >> job;
}


std::ostream& operator<<(std::ostream& os, const abstr_emp& e)
{
	os << "Firstname: " << e.fname << "\nLastname: " << e.lname
		<< "\nJob: " << e.job << std::endl;
	return os;
}

void manager::ShowAll() const
{
	abstr_emp::ShowAll();
	std::cout << "In chagre of: " << inchargeof << std::endl;
}

void manager::SetAll()
{
	//abstr_emp::SetAll();
	std::cout << "Enter the count of charge: ";
	std::cin >> inchargeof;
}

void fink::ShowAll() const
{
	abstr_emp::ShowAll();
	std::cout << "Reports to: " << reportsto << std::endl;
}

void fink::SetAll()
{
	//abstr_emp::SetAll();
	std::cout << "Enter who should report to: ";
	std::cin >> reportsto;
}

void highfink::ShowAll() const
{
	abstr_emp::ShowAll();
	std::cout << "Reports to: " << fink::ReportsTo() << "\n";
	std::cout << "In charge of: " << manager::InChargeOf() << "\n";
}

void highfink::SetAll()
{
	abstr_emp::SetAll();
	fink::SetAll();
	manager::SetAll();
}

