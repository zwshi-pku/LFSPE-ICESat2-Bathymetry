function [atl03, id, name]= select_icesat2_data(choice)
atl03 = [];
id = [];
name = 'night';
switch choice
    case 'A'
        FILE_NAME = 'studyAreaData\ATL03_20190222135159_08570207_006_02.h5';
        bm = '/gt3l';
        atl03 = getatl03(FILE_NAME, bm, false);
        id = atl03.lat < 16.555 & atl03.lat > 16.53;
        [median(atl03.lat(id)) median(atl03.lon(id))]
        savecsv(atl03, id, 'lltA.csv');

    case 'C'
        FILE_NAME = 'studyAreaData\ATL03_20190211025118_06820207_006_02.h5';
        bm = '/gt2r';
        atl03 = getatl03(FILE_NAME, bm, false);
        id = atl03.lat < 22.62 & atl03.lat > 22.52;
        [median(atl03.lat(id)) median(atl03.lon(id))]
        savecsv(atl03, id, 'lltC.csv');

    case 'D'
        FILE_NAME = 'studyAreaData\ATL03_20201109234112_07150901_006_01.h5';
        bm = '/gt3r';
        atl03 = getatl03(FILE_NAME, bm, false);
        id = atl03.lat < 12.52 & atl03.lat > 12.4791;
        [median(atl03.lat(id)) median(atl03.lon(id))]
        savecsv(atl03, id, 'lltD.csv');

    case 'E'
        FILE_NAME = 'studyAreaData\ATL03_20181015121227_02580101_006_02.h5';
        bm = '/gt3r';
        atl03 = getatl03(FILE_NAME, bm, false);
        id = atl03.lat < 14.02 & atl03.lat > 14.007;
        [median(atl03.lat(id)) median(atl03.lon(id))]
        savecsv(atl03, id, 'lltE.csv');

    case 'F'
        FILE_NAME = 'studyAreaData\ATL03_20181018004230_02960108_006_02.h5';
        bm = '/gt1r';
        atl03 = getatl03(FILE_NAME, bm, false);
        id = atl03.lat < -8.42 & atl03.lat > -8.58;
        [median(atl03.lat(id)) median(atl03.lon(id))]
        savecsv(atl03, id, 'lltF.csv');

    case 'H'
        FILE_NAME = 'studyAreaData\ATL03_20181209231549_11050101_006_02.h5';
        bm = '/gt1r';
        atl03 = getatl03(FILE_NAME, bm, false);
        id = atl03.lat < 21.38 & atl03.lat > 21.3159;
        [median(atl03.lat(id)) median(atl03.lon(id))]
        savecsv(atl03, id, 'lltH.csv');


    otherwise
        disp('Invalid choice. Please select a valid option.');
end
end

