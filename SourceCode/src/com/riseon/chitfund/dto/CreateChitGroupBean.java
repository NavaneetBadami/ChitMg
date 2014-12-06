package com.riseon.chitfund.dto;

public class CreateChitGroupBean {

	
	private  String agentId;
	private String agentName;
	private String groupId;
	private String groupName;
	private double chitAmount;
	private double duration;
	private int totalMembers;	//same
	private double premium;
	private int totalAuctions;
	private int remainingAuctions;
	private double agentPer;
	private  String grpcredate ;
	private  String grpcretime;
	private  String grpStatus;
	
	public String getGrpcredate() {
		return grpcredate;
	}
	public void setGrpcredate(String grpcredate) {
		this.grpcredate = grpcredate;
	}
	public String getGrpcretime() {
		return grpcretime;
	}
	public void setGrpcretime(String grpcretime) {
		this.grpcretime = grpcretime;
	}
	public String getGrpStatus() {
		return grpStatus;
	}
	public void setGrpStatus(String grpStatus) {
		this.grpStatus = grpStatus;
	}
	public double getAgentPer() {
		return agentPer;
	}
	public void setAgentPer(double agentPer) {
		this.agentPer = agentPer;
	}
	public int getTotalAuctions() {
		return totalAuctions;
	}
	public void setTotalAuctions(int totalAuctions) {
		this.totalAuctions = totalAuctions;
	}
	public int getRemainingAuctions() {
		return remainingAuctions;
	}
	public void setRemainingAuctions(int remainingAuctions) {
		this.remainingAuctions = remainingAuctions;
	}
	private int totalMemberSlots;  //same
	private int availableMemberSlots;

	public String getGroupId() {
		return groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getAgentId() {
		return agentId;
	}
	public void setAgentId(String agentId) {
		this.agentId = agentId;
	}
	public String getAgentName() {
		return agentName;
	}
	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}
	public double getChitAmount() {
		return chitAmount;
	}
	public void setChitAmount(double chitAmount) {
		this.chitAmount = chitAmount;
	}
	public double getDuration() {
		return duration;
	}
	public void setDuration(double duration) {
		this.duration = duration;
	}
	public int getTotalMembers() {
		return totalMembers;
	}
	public void setTotalMembers(int totalMembers) {
		this.totalMembers = totalMembers;
	}
	public double getPremium() {
		return premium;
	}
	public void setPremium(double premium) {
		this.premium = premium;
	}
	public int getTotalMemberSlots() {
		return totalMemberSlots;
	}
	public void setTotalMemberSlots(int totalMemberSlots) {
		this.totalMemberSlots = totalMemberSlots;
	}
	public int getAvailableMemberSlots() {
		return availableMemberSlots;
	}
	public void setAvailableMemberSlots(int availableMemberSlots) {
		this.availableMemberSlots = availableMemberSlots;
	}
}
