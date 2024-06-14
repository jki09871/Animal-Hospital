package com.review.util;

import com.review.controller.animal.AnimalController;
import com.review.controller.animal.AnimalOwnerController;
import com.review.dto.animal.AnimalMemberDTO;
import com.review.service.animal.OwnerService;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Component
public class MailSenderUtils {

    @Setter(onMethod_ = @Autowired)
    private OwnerService os;
    @Setter(onMethod_ = @Autowired)
    private JavaMailSender mailSender;


    public void MailSenderUtils(AnimalMemberDTO animalMemberDTO) throws Exception {
        System.out.println("animalDTO = " + animalMemberDTO);

        if (os.findPw(animalMemberDTO) != 0) {
            Pbkdf2PasswordEncoderUtil pbkdf2PasswordEncoderUtil = new Pbkdf2PasswordEncoderUtil();

            AnimalOwnerController controller = new AnimalOwnerController();
            String randomPw = controller.generateRandomString();

            String randomP2 = pbkdf2PasswordEncoderUtil.pbkdf2PasswordEncoder.encode(randomPw);
            animalMemberDTO.setPassword(randomP2);
            os.pwUpdate(animalMemberDTO);

            try {
                MimeMessage mimeMessage = mailSender.createMimeMessage();
                MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                messageHelper.setFrom("ghdwjdrl1234@gmail.com");

                messageHelper.setTo(animalMemberDTO.getEmail()); /** 받을 이메일 */
                messageHelper.setSubject("동물 입양센터입니다. 임시 비빌번호 발송되었습니다."); /** 이메일 제목 */

                String emailContent = "<html><body>" +
                        "<h3>안녕하세요, 동물 입양센터입니다.</h3>" +
                        "<p>임시 비밀번호가 발송되었습니다. 아래의 정보를 확인해 주세요:</p>" +
                        "<p><strong>임시 비밀번호:</strong> " + randomPw + "</p>" +
                        "<p>감사합니다.</p>" +
                        "</body></html>";

                messageHelper.setText(emailContent, true); // true indicates HTML

                mailSender.send(mimeMessage);
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }

        }
    }
}


