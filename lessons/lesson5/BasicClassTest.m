x = 1:10;
a = BasicClass(x);       % runs the BasicClass constructor, creates a BasicClass object
y = a.findClosest(5.4);  % runs the method findClosest

%%
z = a.vals;              % Doesn't work, properties are private

%%
z = a.getVals();         % Have to use this getter