#include "pch.h"
#include "classic.h"


classic::classic() 
{
	//cd::cd();
	strcpy_s(maintheme, 50, "none");
}

classic::classic(const char *mt, const char *s1, const char *s2, int n, double x) : cd(s1, s2, n, x)
{
	strcpy_s(maintheme, 50, mt);
}

void classic::Report() const
{
	cd::Report();
	std::cout << "The maintheme: " << maintheme << "\n";
}

classic& classic::operator=(const classic &d)
{
	cd::operator=(d);
	strcpy_s(maintheme, 50, d.maintheme);
	return *this;
}

classic::~classic()
{
}
