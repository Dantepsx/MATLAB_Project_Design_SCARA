function poses = interpolate_trajectory(p_start, p_end, v_linear, t_total)
    % Funzione per interpolare la traiettoria tra due punti con il profilo di velocità lineare
    
    n_points = length(v_linear);
    poses = zeros(n_points, 4);
    
    % Calcolo delle traiettorie
    for i = 1:n_points
        % Interpolazione lineare delle posizioni (x, y, z)
        poses(i, 1:3) = p_start(1:3) + (p_end(1:3) - p_start(1:3)) * (v_linear(i) / v_linear(end));
        
        % Interpolazione dell'orientamento (considerando il moto più breve)
        delta_theta = p_end(4) - p_start(4);
        if abs(delta_theta) > pi
            delta_theta = delta_theta - sign(delta_theta) * 2 * pi;
        end
        poses(i, 4) = p_start(4) + delta_theta * (v_linear(i) / v_linear(end));
    end
end