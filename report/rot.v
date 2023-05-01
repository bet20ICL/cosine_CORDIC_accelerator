
always@(*) begin 
    if(z[20]==0) begin
        rot_x = x - (y >>> i);
        rot_y = y + (x >>> i);
        rot_z = z - lut_angles[i];
    end 
    else begin
        rot_x = x + (y >>> i);
        rot_y = y - (x >>> i);
        rot_z = z + lut_angles[i];
    end
end

// Explict
always@(*) begin
    z_replicated = {21{z[20]}};
    y_shift = (y>>>rotate_index);
    x_shift = (x>>rotate_index);
    rot_x = x + (y_shift ^ ~z_replicated) + !z[20]; 
    rot_y = y + (x_shift ^ z_replicated) + z[20]; 
    rot_z = z + (lut_angles[i] ^ ~z_replicated) + !z[20]; 
end
