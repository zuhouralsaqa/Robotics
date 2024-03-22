function Rotation_matrix = rotation_guess(val_raw1, val_raw2, val_raw3, column_order)

global raw1_val raw2_val raw3_val
raw1_val = val_raw1; raw2_val = val_raw2; raw3_val = val_raw3;

IG = rand(1, 6); % Initial guesses.

sol = fsolve('rotation_fun', IG); % Solution.

% disp(sol)

R = [raw1_val,sol(1),  sol(2)   ;
     sol(3),  raw2_val,sol(4)   ;
     sol(5),  sol(6),  raw3_val];
 


Rotation_matrix = [R(:,(find(column_order==1))), R(:,(find(column_order==2))), R(:,(find(column_order==3)))];
end


% example
% R = [   _    −0.9186     _
%       0.8839    _        _
%         _       _     −0.9186]

% column_order = [2,1,3];
% R = rotation_guess(-0.9186, 0.8839, 0.866, [2,1,3])