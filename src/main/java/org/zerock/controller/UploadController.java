package org.zerock.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

@Controller
@Log4j2
public class UploadController {

    // 년/월/일 폴더의 생성
    private String getFolder(){
        log.debug("getFolder() invoked.");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);
    } //getFolder


    @GetMapping("/uploadForm")
    public void uploadForm(){
        log.debug("uploadForm() invoked.");

    } //uploadForm

    @PostMapping("/uploadFormAction")
    public void uploadFormPost(MultipartFile[]uploadFile, Model model){
        log.debug("uploadFormPost({}, {}) invoked.", uploadFile, model);

        String uploadFolder = "/Users/jeongminji/Etc/upload";

        for(MultipartFile multipartFile : uploadFile){
            log.info("------------------");
            log.info("Upload File Name : " + multipartFile.getOriginalFilename());
            log.info("Upload File Size : " + multipartFile.getSize());

            File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());

            try {
                multipartFile.transferTo(saveFile);
            } catch(Exception e){
                log.error(e.getMessage());
            } //try-catch

        } //enhanced-for
    } //uploadForm


    @GetMapping("/uploadAjax")
    public void uploadAjax(){
        log.debug("uploadAjax() invoked.");

    } //uploadAjax


    @PostMapping("/uploadAjaxAction")
    public void uploadAjaxPost(MultipartFile[] uploadFile){
        log.debug("uploadAjaxPost({}) invoked", uploadFile);

        String uploadFolder = "/Users/jeongminji/Etc/upload";

        //----------- make folder
        File uploadPath = new File(uploadFolder, getFolder());
        log.info("upload path : " + uploadPath);

        if(uploadPath.exists() == false){
            uploadPath.mkdirs();
        } //if : 해당 업로드 경로가 존재하지 않으면, 새로운 디렉토리(yyyy/MM/dd) 생성.

        for(MultipartFile multipartFile : uploadFile){
            log.info("------------------");
            log.info("Upload File Name : " + multipartFile.getOriginalFilename());
            log.info("Upload File Size : " + multipartFile.getSize());

            String uploadFileName = multipartFile.getOriginalFilename();

            // IE has file path
            // IE는 전체 파일 경로가 전송되므로, 마지막 \ 를 기준으로 잘라낸 문자열이 실제 파일이름이 됨.
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

            log.info("only filename : " + uploadFileName);

            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid.toString() + "_" + uploadFileName;
            
            File saveFile = new File(uploadPath, uploadFileName);

            try {
                multipartFile.transferTo(saveFile);
            } catch(Exception e){
                log.error(e.getMessage());
            } // try-catch

        } //enhanced for

    } //uploadAjaxPost



} //end class
