function [ arc_connectivity, point_coordinates, arc_diameters ] = CleanupGraph(arc_connectivity, point_coordinates, arc_diameters )
% SAM 8/10/23

% cleanup the graph to have good topology for fluid flow simulation

% e.g. [ arc_connectivity, point_coordinates, arc_diameters ] = CleanupGraph(faceMx(:,2:3),ptCoordMx,dia)

%% check connected components

arc_connectivity_upper = sort(arc_connectivity,2);

G = graph(sparse(arc_connectivity_upper(:,1),...
                 arc_connectivity_upper(:,2),...
       ones(size(arc_connectivity_upper(:,1))), ...
             max(arc_connectivity_upper(:)), ...
             max(arc_connectivity_upper(:))), 'upper');

bins = conncomp(G); % nodes2connectedComponents

uniques = unique( bins );

bin_count = zeros( length(uniques), 1 );

for unique_bin = uniques

    bin_count( unique_bin ) = sum( bins == unique_bin );

end

%% sort components (from most to fewest nodes)
[bin_count_sorted, sorting_index ] = sort( bin_count, 'descend' );

% figure
% plot( bin_count_sorted )

[~,sorting_index_inverse] = sort( sorting_index );

bins = sorting_index_inverse(bins);

%% plot component size histogram
number_of_bins = max( bins );

% figure
% histogram( bins, number_of_bins )
% 
% % % only the residual components
% % bins(bins==1)=[];
% % 
% % figure
% % histogram( bins, number_of_bins )

%% assign group ID to connected components
edges2bins = bins(arc_connectivity( :, 1 ));

%% plot all connected components together using group ID for color
faceMx = [zeros(size(arc_connectivity(:,1))), arc_connectivity];
ptCoordMx = point_coordinates( :, 1 : 3 ); % point_coordinates may have extra columns e.g. diameter
dia  = arc_diameters ;

figure
[T,f]=RenderTubesAsTrianglesTV(ptCoordMx,faceMx,dia,edges2bins,[], "full network by component",jet(255)); % AL -> SAM (__@uic.edu) on 8/11/23

%% plot each connected component one-by-one
for comp_idx = 1 : 5

    arc_connectivity_temp = arc_connectivity( edges2bins == comp_idx, : );
       arc_diameters_temp = arc_diameters(    edges2bins == comp_idx    );

%     arc_connectivity_temp( )

    faceMx = [zeros(size(arc_connectivity_temp(:,1))), arc_connectivity_temp];
    dia  = arc_diameters_temp ;

    figure
    [T,f]=RenderTubesAsTrianglesTV(ptCoordMx,faceMx,dia,dia,[], ['component #', num2str( comp_idx )],jet(255)); % AL -> SAM (__@uic.edu) on 8/11/23

end

end