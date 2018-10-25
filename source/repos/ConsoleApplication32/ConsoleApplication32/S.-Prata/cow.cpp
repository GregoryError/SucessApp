#include "stdafx.h"
#include "cow.h"


Cow::Cow()
{
	strcpy_s(name, 8, "unknown");
	hobby = nullptr;
	weight = 0.0;
}


Cow::Cow(const char *nm, const char *ho, double wt)
{
	if (std::strlen(nm) <= 20)
	{
		strcpy_s(name, std::strlen(nm) + 1, nm);
	}

	int len = std::strlen(ho) + 1;
	hobby = new char[len];
	strcpy_s(hobby, len, ho);
	weight = wt;
}

Cow::Cow(const Cow &c)
{
	strcpy_s(name, std::strlen(c.name) + 1, c.name);
	int len = std::strlen(c.hobby) + 1;
	hobby = new char[len];
	strcpy_s(hobby, len, c.hobby);
	weight = c.weight;
}

Cow &Cow::operator=(const Cow &c)
{
	if (this == &c)
		return *this;
	delete[] hobby;
	strcpy_s(name, std::strlen(c.name) +1, c.name);
	int len = std::strlen(c.hobby) + 1;
	hobby = new char[len];
	strcpy_s(hobby, len, c.hobby);
	weight = c.weight;	
}

void Cow::ShowCow() const
{
	std::cout << "The name is: " << name << "\n";
	if (hobby != nullptr)
	std::cout << "The hobby is: " << hobby << "\n";
	std::cout << "The weight is: " << weight << "\n";
}

Cow::~Cow()
{
	delete[] hobby;
}