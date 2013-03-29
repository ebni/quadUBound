function u = uBound2QB(D, n, a)
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

if (D <= 1-a)
  u = D;
elseif (D/a < (3-n)/(n-1)+sqrt(((3-n)/(n-1))^2+1/(a*a)-1))
  u = D-(n-1)*(a+D-1)^2/(4*a);
else
  u = (n-1)*(a+D-sqrt((a+D)^2-4*a*D/(n-1)))/(2*a);
end
