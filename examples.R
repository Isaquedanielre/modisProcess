reprojectHDF('MCD12Q1.A2001001.h11v05.051.2014287162250.hdf', 'tmp.tif',
             'C:/MODIS_MRT/bin/', UL="",LR="",
             proj_type="SIN", proj_params = 6371007.181 ,datum='NoDatum')
reprojectHDF('MCD12Q1.A2001001.h11v05.051.2014287162250.hdf',
             'G:/MODIS/MCD12Q1/MCD12Q1.A2001001.h11v05.051.2014287162250.tif',
              MRT_bin_DIR,  proj_type="UTM", utm_zone=18)

modisReprojectAll(inoutDir = 'G:/MODIS/MCD12Q1/', PIXEL_SIZE = 1000)
modisReprojectAll(inoutDir = 'G:/MODIS/MCD12Q2/', PIXEL_SIZE = 1000)

modisReprojectAll(inDir = 'G:/example', outDir='G:/example/out/', PIXEL_SIZE = 1000)
