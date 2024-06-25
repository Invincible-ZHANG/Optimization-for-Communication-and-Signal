%init
A = zeros(5,10);
B = zeros(5,10);

A = rand(5,10) *10;

C = sum(A, 2);
[~, index] = sort(C , 'descend');
A_sort = A(index, :);
A = A_sort;

disp('Matrix A :');
disp(A);


%reduce time complexity
D = (A <= 5);
disp('Matrix D :');
disp(D);


for i = 1:5
    for j = 1:10
        if (A(i,j) <= 5)
            B(i,j) = 1;
        end
        if (A(i,j) > 5)
            B(i,j) = 0;
        end
                
    end
end
disp('Matrix B :');
disp(B);

