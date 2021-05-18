%% Lesson 11: App Designer, cont'd.

% We know how to use MATLAB in from MATLAB scripts in the MATLAB editor,
% but what if we want to be able to run a MATLAB program from a GUI
% (graphical user interface)?

% MATLAB "Apps" allow you to do this. MATLAB apps, like the Filter Designer
% App we've used, allow you to design a graphical application using MATLAB
% logic. You can deploy it so that users can use it in MATLAB (like the
% filter designer tool), or you can even deploy it outside MATLAB as a web
% application or standalone desktop application!

% What's more, it's easy to design an app in MATLAB using the appdesigner()
% tool. All you need to do is drag-and-drop GUI components and add handlers
% (callbacks), and then you're done! You can then export it to a .m file,
% share it as a MATLAB App, or distribute it as a web app or executable.
appdesigner;