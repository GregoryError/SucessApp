#include "pch.h"
#include "port.h"



Port::Port(const char *br, const char *st, int b)
{
	brand = new char[std::strlen(br) + 1];
	strcpy_s(brand, std::strlen(br) + 1, br);
	strcpy_s(style, 20, st);
	bottles = b;
}

Port::Port(const Port &p)
{
	brand = new char[std::strlen(p.brand)];
	strcpy_s(brand, std::strlen(p.brand), p.brand);
	strcpy_s(style, 20, p.style);
	bottles = p.bottles;
}

Port &Port::operator=(const Port &p)
{
	if (this == &p)
		return *this;
	delete[] brand;
	brand = new char[std::strlen(p.brand) + 1];
	strcpy_s(brand, std::strlen(p.brand) + 1, p.brand);
	strcpy_s(style, 20, p.style);
	bottles = p.bottles;
	return *this;
}

Port &Port::operator+=(int b)
{
	if (b >= 0)
		bottles += b;
	return *this;
}

Port &Port::operator-=(int b)
{
	if (bottles >= b)
		bottles -= b;
	return *this;
}


std::ostream &operator<<(std::ostream &os, const Port &p)
{
	os << p.brand << ", " << p.style << ", " << p.bottles;
	return os;
}


VintagePort::VintagePort()
{
	nickname = nullptr;
	year = 0;
}

VintagePort::VintagePort(const char *br, int b, const char *nn, int y) : Port(br, "none", b)
{
	nickname = new char[std::strlen(nn) + 1];
	strcpy_s(nickname, std::strlen(nn) + 1, nn);
	year = y;
}

VintagePort::VintagePort(const VintagePort& vp) : Port(vp)
{
	nickname = new char[std::strlen(vp.nickname) + 1];
	strcpy_s(nickname, std::strlen(vp.nickname) + 1, vp.nickname);
	year = vp.year;
}


VintagePort &VintagePort::operator=(const VintagePort& vp)
{
	if (this == &vp)
		return *this;
	delete[] nickname;
	Port::operator=(vp);
	nickname = new char[std::strlen(vp.nickname) + 1];
	strcpy_s(nickname, std::strlen(vp.nickname) + 1, vp.nickname);
	year = vp.year;
}


void Port::Show() const
{
	std::cout << "Brand: " << brand << '\n';
	std::cout << "Kind: " << style << '\n';
	std::cout << "Bottles: " << bottles << '\n';
}


void VintagePort::Show() const
{
	Port::Show();
	std::cout << "Nickname: " << nickname << '\n';
	std::cout << "Year: " << year << '\n';
}

std::ostream &operator<<(std::ostream &os, const VintagePort& vp)
{
	std::cout << (const Port &)vp << vp.nickname << vp.year;
	return os;
}
