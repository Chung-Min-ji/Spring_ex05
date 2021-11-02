package org.zerock.controller;

import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@Log4j2
public class UploadController {

    //-- 년/월/일 폴더의 생성
    private String getFolder(){
        log.debug("getFolder() invoked.");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);
    } //getFolder


    //-- 첨부파일이 이미지 타입인지를 검사
    private boolean checkImageType(File file){
        log.debug("checkImageType({}) invoked.", file);

        try{
            String contentType = Files.probeContentType(file.toPath());

            return contentType.startsWith("image");
        }catch(IOException e){
            e.printStackTrace();;
        } //try-catch

        return false;

    } //checkImageType


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


    @PostMapping(value="/uploadAjaxAction",
                produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){
        log.debug("uploadAjaxPost({}) invoked", uploadFile);

        List<AttachFileDTO> list = new ArrayList<>();
        String uploadFolder = "/Users/jeongminji/Etc/upload";

        String uploadFolderPath = getFolder();

        //----------- make folder
        File uploadPath = new File(uploadFolder, getFolder());
        log.info("upload path : " + uploadPath);

        if(uploadPath.exists() == false){
            uploadPath.mkdirs();
        } //if : 해당 업로드 경로가 존재하지 않으면, 새로운 디렉토리(yyyy/MM/dd) 생성.

        for(MultipartFile multipartFile : uploadFile){

            AttachFileDTO attachDTO = new AttachFileDTO();

            String uploadFileName = multipartFile.getOriginalFilename();

            // IE has file path
            // IE는 전체 파일 경로가 전송되므로, 마지막 \ 를 기준으로 잘라낸 문자열이 실제 파일이름이 됨.
            uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

            log.info("only filename : " + uploadFileName);

            // 파일명 중복방지 위한 UUID 생성
            UUID uuid = UUID.randomUUID();

            uploadFileName = uuid.toString() + "_" + uploadFileName;

            try {
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setUuid(uuid.toString());
                attachDTO.setUploadPath(uploadFolderPath);

                // check image type file
                if(checkImageType(saveFile)){
                    FileOutputStream thumbnail = new FileOutputStream(
                            // 원본 파일은 그대로 저장되고,
                            // 파일 이름이 's_'로 시작하는 섬네일 파일이 함께 생성됨.
                            new File(uploadPath, "s_" + uploadFileName));
                    Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,100, 100);

                    thumbnail.close();
                } //if

            } catch(Exception e){
                log.error(e.getMessage());
            } // try-catch

        } //enhanced for

        return new ResponseEntity<>(list, HttpStatus.OK);
    } //uploadAjaxPost



} //end class
