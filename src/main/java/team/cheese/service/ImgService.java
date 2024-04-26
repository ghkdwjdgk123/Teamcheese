package team.cheese.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import team.cheese.dao.ImgDao;
import team.cheese.domain.ImgDto;

import java.util.HashMap;

@Service
public class ImgService {
    @Autowired
    ImgDao imgDao;

    public int reg_img(ImgDto imgDto){
        return imgDao.insert_img(imgDto);
    }

    public int view_img(HashMap map){
        return imgDao.insert_img(map);
    }

}
