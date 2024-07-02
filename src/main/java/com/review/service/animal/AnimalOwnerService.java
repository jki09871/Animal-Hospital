package com.review.service.animal;

import com.review.dto.animal.AnimalMemberDTO;
import com.review.dto.animal.AnimalInquiryCommentDTO;
import com.review.repository.animal.AnimalOwnerRepository;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Log4j
@Service
@RequiredArgsConstructor
public class AnimalOwnerService {

    @Setter(onMethod_ = @Autowired)
    private AnimalOwnerRepository or;

    /********************** 회원가입 **********************/
    public int postSignupScreen(AnimalMemberDTO animalDTO) {
        return or.postSignupScreen(animalDTO);
    }
    /*****************************************************/


    /***************** 회원가입 중복이메일 확인 **************/
    public boolean joinEmailCheck(Map<String, Object> valid) {
        System.out.println("valid = " + valid);
      int valid2 = or.joinEmailCheck(valid);

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
    public AnimalMemberDTO userVerification(AnimalMemberDTO animalDTO) {
        return or.userVerification(animalDTO);
    }
    /*****************************************************/

    public AnimalMemberDTO myInformation(Object ownerId) {
       return or.myInformation(ownerId);
    }

    public void editInfo(AnimalMemberDTO animalDTO) {
        or.editInfo(animalDTO);
    }

    public List<AnimalInquiryCommentDTO> commentIWrote(Map<String,Object> ownerId) {
        return or.commentIWrote(ownerId);
    }

    public void keepLogin(String owner_Id, String session_key, Date session_limit) throws  Exception{
        or.keepLogin(owner_Id, session_key, session_limit);
    }

    public AnimalMemberDTO checkLoginBefore(String value) throws Exception {
        return or.checkUserWitSessionKey(value);
    }

    public String findId(Map<String, Object> map) {
        return or.findId(map);
    }

    public int findPw(AnimalMemberDTO animalMemberDTO){
        return or.findPw(animalMemberDTO);

    }

    public void pwUpdate(AnimalMemberDTO memberDTO){
        or.pwUpdate(memberDTO);
    }


    public void pwChange(AnimalMemberDTO memberDTO) {
        or.pwChange(memberDTO);
    }

    public void pwFailCount(AnimalMemberDTO animalDTO) {
        or.pwFailCount(animalDTO);
    }

    public void pwFailReset(AnimalMemberDTO animalDTO) {
        or.pwFailReset(animalDTO);
    }

}
