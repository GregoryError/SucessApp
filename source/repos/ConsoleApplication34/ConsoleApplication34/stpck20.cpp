#include "pch.h"
#include "stpck20.h"


Stock::Stock()
{
	company_str = nullptr;
	str_len = 0;
	shares = 0;
	share_val = 0.0;
	total_val = 0.0;
}


Stock::Stock(const char *co, long n, double pr)
{
	

	str_len = std::strlen(co);
	company_str = new char[str_len + 1];
	strcpy_s(company_str, str_len + 1, co);


	if (n < 0)
	{
		std::cout << "Number of shares cant be negative; "
			<< company_str << " shares set to 0.\n";
		shares = 0;
	}
	else
		shares = n;
	share_val = pr;
	set_tot();
}

void Stock::buy(long num, double price)
{
	if (num < 0)
	{
		std::cout << "Number of shares purchased cant be negative. "
			<< "Transaction aborted.\n";
	}
	else
	{
		shares += num;
		share_val = price;
		set_tot();
	}
}

void Stock::sell(long num, double price)
{
	using std::cout;
	if (num < 0)
	{
		cout << "Number of shares sold cant be negative. "
			<< "Transaction is aborted.\n";
	}
	else if (num > shares)
	{
		cout << "You cant sell more than you have! "
			<< "Transaction is aborted.\n";
	}
	else
	{
		shares -= num;
		share_val = price;
		set_tot();
	}
}

void Stock::update(double price)
{
	share_val = price;
	set_tot();
}

std::ostream &operator<<(std::ostream &os, const Stock &s)
{
	using namespace std;

	ios_base::fmtflags orig =
		os.setf(ios_base::fixed, ios_base::floatfield);
	streamsize prec = os.precision(3);
	os << "Company: " << s.company_str
		<< " Shares: " << s.shares << '\n';
	os << " Share price: $" << s.share_val;
	os.precision(2);
	os << " Total worth: $" << s.total_val << '\n';
	os.setf(orig, ios_base::floatfield);
	os.precision(prec);
	return os;
}

const Stock &Stock::topval(const Stock &s) const
{
	if (s.total_val > total_val)
		return s;
	else
		return *this;
}

Stock::~Stock()
{
	delete[] company_str;
}
