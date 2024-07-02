package com.review.repository.animal;

import com.review.dto.animal.AnimalBannerDTO;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class AnimalBannerRepository {

    @Setter(onMethod_ = @Autowired)
    private final SqlSessionTemplate sql;

    public void bannerRegister(AnimalBannerDTO bannerDTO) {
        System.out.println("####bannerDTO = " + bannerDTO);
        sql.insert("banner.bannerRegister", bannerDTO);
    }

    public int bannerIdMaxCount() {
        return sql.selectOne("banner.maxNumber");
    }

    public void insertFile(Map<String, Object> map) {
        sql.insert("file.insertFile", map);
    }

    public List<AnimalBannerDTO> bannerList() {
        return sql.selectList("banner.bannerList");
    }

    public AnimalBannerDTO bannerRead(AnimalBannerDTO bannerDTO){
        return sql.selectOne("banner.bannerRead", bannerDTO);
    }

    public void bannerModify(AnimalBannerDTO bannerDTO) {

        sql.update("banner.bannerModify", bannerDTO);
    }

}
