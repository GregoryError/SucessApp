#ifndef TEST_H
#define TEST_H


class location
{
public:
    float longitude, latitude;
    QString address;
    float t_long, t_lat;

    location() = default;
    location(const float &lon, const float &lat):longitude(lon), latitude(lat){}
    location(const float &lon, const float &lat, const QString &addr, const float &t_long, const float &t_lat):
        longitude(lon), latitude(lat), address(addr), t_long(t_long), t_lat(t_lat) {}

    float ShowDiff(location &first, location &second)
    {
         return std::abs(pow(pow((second.latitude - first.latitude), 2) + pow((second.longitude - first.longitude), 2), 0.5));
    }

    bool operator <(location &obj)
    {
        location temp(longitude, latitude);
        location own(t_long, t_lat);
        return ShowDiff(own, temp) < ShowDiff(own, obj);
    }

    bool operator >(location &obj)
    {
        location temp(longitude, latitude);
        location own(t_long, t_lat);
        return ShowDiff(own, temp) > ShowDiff(own, obj);
    }
};




#endif // TEST_H
