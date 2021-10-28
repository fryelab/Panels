%make_8_wide_stripe_pattern_12.m
% 12 panels in a circle -> 96 columns, 1 panel high -> 8 rows
InitPat = [ones(8,88) zeros(8,8)];

pattern.x_num = 96;
pattern.y_num = 1;
pattern.num_panels = 12;
pattern.gs_val = 1;

Pats = zeros(8, 96, pattern.x_num, pattern.y_num);
Pats(:,:,1,1) = InitPat;

for j = 2:96
    Pats(:,:,j,1) = ShiftMatrix(Pats(:,:,j-1,1), 1, 'r', 'y'); 
end

pattern.Pats = Pats;
pattern.Panel_map = [1 5 9 2 6 10 3 7 11 4	8 12;...
13 17 21 14 18 22 15 19 23 16 20 24];
pattern.BitMapIndex = process_panel_map(pattern);
pattern.data = make_pattern_vector(pattern);

directory_name = 'C:\Program Files (x86)\MATLAB\MatlabRoot\Panels\Patterns\saratest';
str = [directory_name '\Pattern_fixation_8_wide_12Pan']
save(str, 'pattern');
