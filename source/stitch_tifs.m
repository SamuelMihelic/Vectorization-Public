function [stitched_tif, image_matrix] = stitch_tifs(directory)

    tif_files = dir([directory,filesep,'*.tif'])';
%     tif_files = dir([directory,filesep,'_\d+.tif'])';

    tif_number = [ ];

    for tif_file = tif_files

        start_idx = regexp( tif_file.name, '_\d+.tif');

        if start_idx

            tif_number = [ tif_number, str2num(tif_file.name( start_idx + 1 : end - 4 ))];

            stitched_tif = [ tif_file.name( 1 : start_idx ), 'stitched.tif'];
        else
            tif_number = [ tif_number, 0 ];

        end
    end

    [~,tif_idx_sorted] = sort(tif_number,'descend');

    numTifs = nnz( tif_number );

    tif_idx_sorted = tif_idx_sorted( 1 : numTifs );

    image_cell = cell(1,1,numTifs);
%     matrix = zeros()

    count = 0 ;

    for idx = tif_idx_sorted

        count = count + 1 ;

        image_cell{count} = tif2mat([directory,filesep,tif_files(idx).name]);
%         matrix = cat( matrix, tif2mat([directory,filesep,tif_file.name]));

    end

    image_matrix = cell2mat(image_cell);

    mat2tif( image_matrix, [directory,filesep,stitched_tif])

end