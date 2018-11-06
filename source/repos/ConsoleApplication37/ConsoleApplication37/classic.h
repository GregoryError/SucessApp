#pragma once
#include "cd.h"
class classic : public cd
{
private:
	char *maintheme;
public:
	classic(const char *mt, const char *s1, 
		const char *s2, int n, double x);
	classic(const cd &c);
	classic();
	classic(const classic &c);
	void Report() const;
	classic &operator=(const classic &d);
	~classic();
};

