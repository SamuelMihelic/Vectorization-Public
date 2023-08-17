function casx_V2_mat2file( casx_file_path, point_coordinates, arc_connectivity, arc_diameters, point_radii )
%  casx_V2_mat2file SAM 230810 (August 10th, 2023)
%  This function writes the three casX output vasriables to three text files in the updated *.casx format.

% number_of_points     =   size( point_coordinates, 1 );
number_of_arcs       = length( arc_diameters        );

arc_connectivity_Mx = [ ones( number_of_arcs, 1 ), ...
                      uint64(  arc_connectivity ), ...
                       zeros( number_of_arcs, 2 )  ];

% ooSaveIntMx(nwk.faceMx, [filename, '.fMx']); % Andreas Linninger (AL) -> SAM on 8/10/23 via email (to: ___@gmail)
ooSaveIntMx(                        arc_connectivity_Mx, ...
     [ casx_file_path, '.fMx' ]);
% save([ casx_file_path, '.fMx' ], 'arc_connectivity_Mx', '-ascii' )
save([ casx_file_path, '.pMx' ],   'point_coordinates', '-ascii' )
save([ casx_file_path, '.dia' ],       'arc_diameters', '-ascii' )

point_coordinates = [ point_coordinates, point_radii ];
save([ casx_file_path, '_Nodes.txt' ],   'point_coordinates', '-ascii' )
ooSaveIntMx(                                arc_connectivity - 1, ... % indexing converted from MATLAB to Python
     [ casx_file_path, '_Edges.txt' ]);

end % FUNCTION casx_file2mat

function ooSaveIntMx(myIntMx, fileName)
% Andreas Linninger (AL) -> SAM on 8/10/23 via email (to: ___@gmail)
fid = fopen(fileName,'w');
nf=length(myIntMx(:,1));
for i=1:nf
  %fprintf(fid, '%20d %20d %20d \n', faceMx(i,1), faceMx(i,2), faceMx(i,3));
  v = myIntMx(i,:);
  fprintf(fid, '%15d',v );
  fprintf(fid, '\n');
end
fclose(fid);
end

%%% BEGIN: fxn: caseReaderAL.m %%%
%     function [faceMx,ptCoordMx,grpMx, dia,BC,np,nf,nt]=caseReaderAL(filename)
%     myfileName = strcat(filename,'.fMx');
%     faceMx = load(myfileName);
%     myfileName = strcat(filename,'.pMx');
%     ptCoordMx = load(myfileName);
%     np= length(ptCoordMx);    nf= length(faceMx(:,2));   nt= np+nf;
%     myfileName = strcat(filename,'.dia');
%     if isfile(myfileName) dia = load(myfileName); 
%     else dia=ones(nf,1); end 
%     myfileName = strcat(filename,'.BC');
%     if isfile(myfileName) BC = load(myfileName);
%     else BC=[1 1 100; 100 1 0.1]; end    
%     myfileName = strcat(filename,'.grpMx');
%    if isfile(myfileName) grpMx = load(myfileName); 
%    else grpMx=[];end    
%     end
%%% END: fxn: caseReaderAL.m %%%

% if isfile( casx_file_path ), delete( casx_file_path ), end
% 
% number_of_points     =   size( point_coordinates, 1 );
% number_of_arcs       = length( arc_diameters        );
% 
% fileID = fopen( casx_file_path, 'a' );
% 
% %% writing header
% affiliation = 'put_your_affiliation_here' ;
% location    = 'put_your_location_here'    ;
% % affiliation = 'SMihelic at FOIL' ;
% % location    = 'Austin, TX'    ;
% date        = char( datetime('now', 'TimeZone', 'local', 'Format', 'MM/dd/yyyy' )); 
% 
% fprintf( fileID, ...
%          [ '//"3d vascular network generation" author="A.Linninger" date="2007-2011"\n',     ...
%            '//File format designed by GHartung and ALinninger 10/9/2018\n',                  ... 
%            '//This file was created by ', affiliation, ' in ', location, ' on: ', date, '\n' ]);
% 
% %% data formatting
% % formatSpec_point_coordinate = '\t%.9E\t%.9E\t%.9E\n' ;
% formatSpec_arc_connectivity =   '%x\t%x\t\n' ;
% formatSpec_arc_diameter     =         '%g\n' ;       
% % formatSpec_groupId          =         '%u\n' ;       
%        
% %% writing point values table
% 
% fprintf( fileID, '\n//point coordinates;   nPoints=%u\n', number_of_points );
% 
% for point_idx = 1 : number_of_points
%     
%     pow = floor(log10(abs(point_coordinates( point_idx, : ))));
%     s = sprintf('\t%.9fE%+.3d', [point_coordinates( point_idx, : )./10.^pow; pow]);
%     
%     fprintf( fileID, [ s, '\n' ]);
% 
% end
% 
% fprintf( fileID, '//end point coordinates\n' );
% 
% %% writing connectivity table
% fprintf( fileID, '\n//arc connectivity matrix;   nArcs=%u\n', number_of_arcs );
% 
% for arc_idx = 1 : number_of_arcs
%    
%     fprintf( fileID, formatSpec_arc_connectivity, arc_connectivity( arc_idx, : ));
%     
% end
% 
% fprintf( fileID, '//end arc connectivity matrix\n' );
% 
% 
% %% writing diameters list
% fprintf( fileID, '\n//diameter: vector on arc;   nArcs=%u\n', number_of_arcs );
% 
% for arc_idx = 1 : number_of_arcs
%    
%     fprintf( fileID, formatSpec_arc_diameter, arc_diameters( arc_idx ));
%     
% end
% 
% fprintf( fileID, '//end diameter\n' );
% 
% %% writing groupId list
% % % !!!! use varargin for this input?
% 
% % fprintf( fileID, '\n//groupId: vector on arc;   nArcs=%u\n', number_of_arcs );
% % 
% % for arc_idx = 1 : number_of_arcs
% %    
% %     fprintf( fileID, formatSpec_groupId, groupId( arc_idx ));
% %     
% % end
% % 
% % fprintf( fileID, '//end groupId\n' );
% 
% 
% %% close file
% fclose( fileID );
% 
% end % FUNCTION casx_file2mat


