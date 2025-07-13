function yfit = gaussian_fit(p,x)
    a = p(1);
    mu = p(2);
    sigma = p(3);
    yfit = a*exp(-((x-mu).^2)/(2*sigma^2));
end