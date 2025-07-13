function radii = calculateRadii(r_min, r_max, z, z_min, z_max)
    % Function to calculate the radii based on the given parameters.
    % Inputs:
    %   r_min - (double) minimum radius
    %   r_max - (double) maximum radius
    %   z     - (double) current z value
    %   z_min - (double) minimum z value
    %   z_max - (double) maximum z value
    % Output:
    %   radii - (double) calculated radius for the given z

    % Calculate the radius based on the given formula
    radii = r_min + (r_max - r_min) * (z_max - z) / (z_max - z_min);
end
