package com.example.demo.callendar;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.callendar.service.CallendarDto;
import com.example.demo.callendar.service.CallendarService;


@RestController
@RequestMapping("/Callendar")
public class CallendarController {
	@Autowired
	private CallendarService<CallendarDto> callendarService;
	
	@PostMapping("/CallenderWrite.do")
	public Map callenderWrite(@RequestBody Map map) {
		System.out.println(map);
		int affected=callendarService.insert(map);
		if(affected==1) {//입력 실패
			map.put("INSERT", "입력을 성공했습니다.");
		}else {
			map.put("INSERT", "입력을 실패했습니다.");
		}
		return map;
	}
	
	@GetMapping("/CallenderList.do")
	public List<CallendarDto> CallenderList() {
		List<CallendarDto> callenderList =callendarService.selectAll();

		return callenderList;
	}
	
	@GetMapping("/CallenderSelectOne.do")
	public CallendarDto CallenderListOne(@RequestParam Map map) {
		CallendarDto callenderListOne =callendarService.selectOne(map);
		System.out.println(callenderListOne);

		return callenderListOne;
	}
		
		
	@DeleteMapping("/CallenderDelete.do")
	public Map CallenderDelete(@RequestParam Map map) {
		int affected =callendarService.delete(map);
		System.out.println(affected);
		if(affected==1) {//입력 실패
			map.put("DeleteOk", "삭제를 성공했습니다.");
		}else {
			map.put("DeleteOk", "삭제를 실패했습니다.");
		}
		return map;
	}
	
	
	
	@PutMapping("/CallenderPut.do")
	public Map CallenderUpdate(@RequestBody Map map,@RequestParam String no) {
		map.put("no",no);
		int affected =callendarService.update(map);
		System.out.println(affected);
		if(affected==1) {//입력 실패
			map.put("UpdateOk", "수정을 성공했습니다.");
		}else {
			map.put("UpdateOk", "수정을 실패했습니다.");
		}
		return map;
	}

}
