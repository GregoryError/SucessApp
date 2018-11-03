#pragma once
#include <cstring>
#include <iostream>

class cd
{
private:
	char performers[50];
	char label[20];
	int selections;
	double playtime;
public:
	cd(const char *s1, const char *s2, int n, double x);
	cd(const cd &d);
	cd();
	~cd();
	virtual void Report() const;
	virtual cd &operator=(const cd &d);
};

