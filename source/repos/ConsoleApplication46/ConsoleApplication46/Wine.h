#pragma once
#include <string>
#include <valarray>
#include <iostream>

template<typename T1, typename T2>
class Pair
{
private:
	T1 a;
	T2 b;
public:
	Pair() = default;
	Pair(T1& fst, T2& scn) : a(fst), b(scn) {};
	void setFirst(const T1& fst) { a = fst; };
	void setSecond(const T2& scn) { b = scn; };
	T1& first() { return a; };
	T2& second() { return b; };
	//T1& first() const { return a; }
	//T2& second() const { return b; }
};



class Wine
{
private:
	std::string label;
	typedef std::valarray<int> ArrayInt;
	typedef Pair<ArrayInt, ArrayInt> PairArray;
	PairArray data;
	int years;

public:
	Wine() { label = "Nothing"; };
	Wine(const char* l, const int y, const int yr[], const int bot[]);
	Wine(const char* l, int y) : label(l), years(y)
	{ 
		data.first().resize(years);
		data.second().resize(years);
	};
	void GetBottles();
	std::string& Label() { return label; };
	int Sum() { return data.second().sum(); }
	void Show();
	~Wine();
};

