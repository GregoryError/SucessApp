#pragma once
#include <cstring>
#include <iostream>
//#include <cctype>

class String
{
	char *str;
	int len;

public:
	String();
	String(const char *s);
	String(const String &obj);
	String &operator=(const String &obj);
	String operator+(const String &obj);
	friend String operator+(const char *s, const String &obj);
	bool operator==(const String &s);
	void stringlow();
	void stringup();
	int has(const char &ch);
	friend std::ostream& operator<<(std::ostream &os, const String &s);
	friend bool operator>>(std::istream &is, String &s);
	~String();
};

