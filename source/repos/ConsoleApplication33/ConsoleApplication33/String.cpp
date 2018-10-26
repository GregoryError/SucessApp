#include "stdafx.h"
#include "String.h"


String::String()
{
	str = nullptr;
	len = 0;
}

String::String(const char *s)
{
	len = std::strlen(s);
	str = new char[len + 1];
	strcpy_s(str, len + 1, s);
}

String::String(const String &obj)
{
	//if (this == &obj)
	//	return;
	//delete[] str;
	len = obj.len;
	str = new char[len + 1];
	strcpy_s(str, len + 1, obj.str);
}

String &String::operator=(const String &obj)
{
	if (this == &obj)
		return *this;
	len = obj.len;
	delete[] str;
	str = new char[len + 1];
	strcpy_s(str, len + 1, obj.str);
	return *this;
}

String String::operator+(const String &obj)
{
	char *tmp = new char[len + obj.len + 1];
	strcpy_s(tmp, len + 1, str);
	strcat_s(tmp, len + obj.len + 1, obj.str);
	String line(tmp);
	delete[] tmp;
	return line;
}

String operator+(const char *s, const String &obj)
{
	return String(s) + obj;
}

void String::stringlow()
{
	for (int i = 0; i < len; ++i)
	{
		char t = towlower(str[i]);
		str[i] = t;
	}
}

void String::stringup()
{
	for (int i = 0; i < len; ++i)
	{
		char t = towupper(str[i]);
		str[i] = t;
	}
}

int String::has(const char &ch)
{
	int val(0);
	for (int i = 0; i < len; ++i)
	{
		if (str[i] == ch)
			++val;
	}
	return val;
}

std::ostream& operator<<(std::ostream &os, const String &s)
{
	os << s.str;
	return os;
}

bool operator>>(std::istream &is, String &s)
{
	char tmp[81];
	is.getline(tmp, 80);
	tmp[80] = '\0';
	s = tmp;
	if (std::strlen(tmp) > 0)
	return true;
	else return false;
} 

bool String::operator==(const String &s)
{
	return std::strcmp(str, s.str) == 0? true : false;
}

String::~String()
{
	delete[] str;
}
