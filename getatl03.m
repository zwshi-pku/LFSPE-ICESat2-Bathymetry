function atl03 = getatl03(FILE_NAME, bm, isShow)
atl03 = []
% geolocation attributes and sig. conf
atl03.alt = double(h5read(FILE_NAME,[bm,'/heights/h_ph'])); % reads elevation
atl03.lat = double(h5read(FILE_NAME,[bm,'/heights/lat_ph']));% reads latitude
atl03.lon = double(h5read(FILE_NAME,[bm,'/heights/lon_ph']));% reads longitude
atl03.dt3 = double(h5read(FILE_NAME,[bm,'/heights/delta_time']));% reads time
atl03.sigc = double(h5read(FILE_NAME,[bm,'/heights/signal_conf_ph']));% signal_conf land
atl03.sigc = atl03.sigc(1,:)';

dtff = atl03.dt3 - atl03.dt3(1);
atl03.atd = cumsum([0;diff(dtff)].*(7000)); % approx alongtrack distance

if isShow
    figure
    plot(atl03.atd, atl03.alt,'.')
    xlabel('Along-track distance (m)')
    ylabel('Elevation (m)')
    axis equal
end