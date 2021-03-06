function writeEnergy(N,T,U)

%This function writes the energy file for the n-link pendulum.

nStateStr = num2str(2*N);

filename = ['energy_' num2str(N) '_link'];

comments{1} = ['[ENERGY, KINETIC, POTENTIAL] = ' upper(filename) '(Z,P)'];
comments{2} = ' ';
comments{3} = 'FUNCTION:  This function computes the energy of a double';
comments{4} = '    pendulum.';
comments{5}  = 'INPUTS: ';
comments{10} = ['    z = [' nStateStr ' X nTime]  matrix of states'];
comments{11} = '    P = struct of parameters';
comments{8}  = 'OUTPUTS: ';
comments{9}  = '    energy = [1 X nTime] vector of total energy';
comments{10} = '    kinetic = [1 X nTime] vector of kinetic energy';
comments{11} = '    potential = [1 X nTime] vector of potential energy';
comments{12} = ' ';
comments{13} = 'NOTES:';
comments{14} = ['    This file was automatically generated by ' mfilename '.m']; 


params{1} = {'g ','gravity'};
params{2} = {'m','mass'};
params{3} = {'l','length'};
params{4} = {'I','moment of inertia about its center of mass'};
params{5} = {'d','distance between center of mass and parent joint'};

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                               write file                                %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
fid = fopen([filename '.m'],'w');

fprintf(fid, ['function [energy, kinetic, potential] = ' filename '(z,P) \n']);

for i=1:length(comments)
    fprintf(fid,['%%' comments{i} '\n']);
end
fprintf(fid,'\n');

for i=1:length(params)
    if i==1  %Gravity, scalar
    fprintf(fid,[params{i}{1} ' = P.' params{i}{1} '; %%' params{i}{2} '\n']);
    else  %unpack vectors:
        for j=1:N
           fprintf(fid,[params{i}{1} num2str(j) ...
               ' = P.' params{i}{1} '(' num2str(j) '); %% Link ' num2str(j) ' ' params{i}{2} '\n']);
        end        
    end
end
fprintf(fid,'\n');

for j = 1:N
   fprintf(fid,['th' num2str(j) ' = z(' num2str(j) ',:); \n']); 
end
fprintf(fid,'\n');

for j = 1:N
   fprintf(fid,['dth' num2str(j) ' = z(' num2str(j+N) ',:); \n']); 
end
fprintf(fid,'\n');

fprintf(fid,['kinetic = ' vectorize(char(T)) ';\n']);
fprintf(fid,['potential = ' vectorize(char(U)) ';\n']);
fprintf(fid,'energy = potential + kinetic;\n\n');
fprintf(fid,'end \n');


fclose(fid);

end


