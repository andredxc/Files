function y = unsharp_masking_gaussian(img);

    kernel = [0 -1 0; -1 4 -1; 0 -1 0]/4;
    

% Laplaciano
	h = [0 -1 0; -1 4 -1; 0 -1 0]/4;
	dg = filter2(h,g);
	y = g + lambda*dg;