package com.review.service;

import com.review.dto.AnimalMemberDTO;
import com.review.repository.AnimalRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Log4j
@Service
@RequiredArgsConstructor
public class AnimalService {

    @Setter(onMethod_ = @Autowired)
    private AnimalRepository ar;

    /********************** 회원가입 **********************/
    public int PostSignupScreen(AnimalMemberDTO animalDTO) {
        return ar.PostSignupScreen(animalDTO);
    }
    /*****************************************************/


    /***************** 회원가입 중복이메일 확인 **************/
    public boolean JoinEmailCheck(Map<String, Object> valid) {
      int valid2 = ar.JoinEmailCheck(valid);

        if (valid2 == 0) {
            log.info("사용 가능한 이메일 또는 아이디 입니다.");
            return true;
        } else {
            log.info("이미 사용중인 이메일 또는 아이디 입니다.");
            return false;
        }
    }
    /*****************************************************/


    /*********************** 로그인 ***********************/
    public AnimalMemberDTO UserVerification(AnimalMemberDTO animalDTO) {
        return ar.UserVerification(animalDTO);
    }
    /*****************************************************/

}
