function u = uBound1QB(D, n, a)
% INPUT
%   D = ratio D_i/T_i
%   n = number of tasks
%   a = max ratio T_i/T_{i+1}
% OUTPUT
%   u = 1st Quadratic Utilization Bound [Bini 2013]

% write explicitly the solution to the case n=1
if (n==1)
  if (D<=1)
    u = D;
  else
    u=1;
  end
  return;
end

% starting from CASE (b), that is when Un > 0
maxHb = min(n-1,4);   % maxHb can never exceed 4 (see Table 1 in [Bini 2013])
isB = 1;
for h=(maxHb+1)-(1:maxHb),  % loop by decreasing h
  LB = 1-a.^h;
  Sh = (1-a^h)/(1-a);
  Rh = (h-2)/Sh;
  X1 = -Rh.*a.^h;
  UB = X1+sqrt(X1.^2+1-a.^(h+1));
  if (UB <= LB)   % loop until a non-empty interval is found
    %disp(h);   % for debugging purpose
    %disp(a);   % for debugging purpose
    continue
  end
  splitBA = UB;
  if (D>=splitBA)
    % it is case (a)
    isB = 0;
    break
  end
  if (D>LB)
    % current h is good
    break
  end
end

if (isB)
  % if h==0, then u=D, as it must be
  u = .25*(4*D-2*(D-1)*h-(a+(D-1)^2*a^(-h))*(1-a^h)/(1-a));
else
  % the 1QB bound is given by case (a)
  startH = h;   % starting from the largest value of h of case (b)
  for h=startH:n-1,
    Sh = (1-a^h)/(1-a);
    Rh = (h-2)/Sh;
    LB = (a-a^h)/(2*(1-Rh));
    if (Rh >= 1 | LB >= D)
      % last h was the good one
      h = h-1;
      break
    end
  end
  aux = (a^(-h)-1)/(1-a);
  u = .5*(h+aux*(D-sqrt(a^(h+1)+2*(h-2)/aux*D+D*D)));
end

end