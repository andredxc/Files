function mat = walsh_code(size)
% size -> number of codes

if size < 1
    fprintf("Size should be greater than 1\n");
    return;
end

num_iter = ceil(log2(size));

mat = [1 1 ; 1 -1];

for i = 2:num_iter
    mat = [mat, mat; mat, -mat];
end
end

