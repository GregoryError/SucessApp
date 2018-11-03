#include "pch.h"
#include "cd.h"


cd::cd()
{
	selections = playtime = 0;
	strcpy_s(performers, 50, "none");
	strcpy_s(label, 50, performers);
}

cd::cd(const char *s1, const char *s2, int n, double x)
	: selections(n), playtime(x)
{
	strcpy_s(performers, 50, s1);
	strcpy_s(label, 20, s2);
}

cd::cd(const cd &d) : selections(d.selections), playtime(d.playtime)
{
	strcpy_s(performers, 50, d.performers);
	strcpy_s(label, 20, d.label);
}

cd& cd::operator=(const cd &d)
{
	selections = d.selections;
	playtime = d.playtime;
	strcpy_s(performers, 50, d.performers);
	strcpy_s(label, 20, d.label);
	return *this;
}


void cd::Report() const
{
	std::cout << "The Artist: " << performers << "\n";
	std::cout << "The label: " << label << "\n";
	std::cout << "The selections: " << selections << "\n";
	std::cout << "The playtime: " << playtime << "\n";
}

cd::~cd()
{
}

