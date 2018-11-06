#include "pch.h"
#include "classic.h"


classic::classic()
{
	maintheme = nullptr;
}

classic::classic(const char *mt, const char *s1,
	const char *s2, int n, double x)
	: cd(s1, s2, n, x)
{
	int len = strlen(mt) + 1;
	maintheme = new char[len];
	strcpy_s(maintheme, len, mt);
}

void classic::Report() const
{
	cd::Report();
	std::cout << "The maintheme: " << maintheme << "\n";
}

classic& classic::operator=(const classic &d)
{
	if (&d == this)
		return *this;
	cd::operator=(d);
	delete[] maintheme;
	int len = strlen(d.maintheme) + 1;
	maintheme = new char[len];
	strcpy_s(maintheme, len, d.maintheme);
	return *this;
}

classic::classic(const classic &c) : cd(c)
{
	int len = strlen(c.maintheme) + 1;
	maintheme = new char[len];
	strcpy_s(maintheme, len, c.maintheme);
}


classic::~classic()
{
	delete[] maintheme;
}
