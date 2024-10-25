package com.accessmanagement.model;

public class Request {
    private int id;
    private String username;
    private int userId;
    private int softwareId;
    private String softwareName;
    private String accessType;
    private String reason;
    private String status;

    public Request() {}

    public Request(String username, int softwareId, String accessType, String reason) {
        this.username = username;
        this.softwareId = softwareId;
        this.accessType = accessType;
        this.reason = reason;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(int softwareId) {
        this.softwareId = softwareId;
    }

    public String getSoftwareName() {
        return softwareName;
    }

    public void setSoftwareName(String softwareName) {
        this.softwareName = softwareName;
    }

    public String getAccessType() {
        return accessType;
    }

    public void setAccessType(String accessType) {
        this.accessType = accessType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Request{" +
               "id=" + id +
               ", userId=" + userId +
               ", softwareId=" + softwareId +
               ", softwareName='" + softwareName + '\'' +
               ", accessType='" + accessType + '\'' +
               ", reason='" + reason + '\'' +
               ", status='" + status + '\'' +
               '}';
    }
}
