Schedule = Schedule(cron = "* 0 2 * * * *", timezone = "GMT", emails = ["email@gmail.com"], enabled = False)

with DAG(Schedule = Schedule):
    annual_enterprise = Task(
        task_id = "annual_enterprise", 
        component = "Dataset", 
        writeOptions = {"writeMode" : "overwrite"}, 
        table = {"name" : "annual_enterprise", "sourceType" : "Seed", "alias" : ""}
    )
    model_parent_all_only_seed_pipeline_1_Join_1 = Task(
        task_id = "model_parent_all_only_seed_pipeline_1_Join_1", 
        component = "Model", 
        modelName = "model_parent_all_only_seed_pipeline_1_Join_1"
    )
    notify_pipeline_success = Task(
        task_id = "notify_pipeline_success", 
        component = "Email", 
        body = "Parent all pipeline buddy", 
        subject = "Parent all pipeline buddy", 
        includeData = False, 
        fileName = "", 
        to = ["abhisheks@prophecy.io"], 
        cc = ["abhisheks@prophecy.io"], 
        fileFormat = "", 
        hasTemplate = False
    )
    service_classification = Task(
        task_id = "service_classification", 
        component = "Dataset", 
        writeOptions = {"writeMode" : "overwrite"}, 
        table = {"name" : "service_classification", "sourceType" : "Seed", "alias" : ""}
    )
    annual_enterprise.out >> model_parent_all_only_seed_pipeline_1_Join_1.in_1
    service_classification.out >> model_parent_all_only_seed_pipeline_1_Join_1.in_1
    model_parent_all_only_seed_pipeline_1_Join_1.out_1 >> notify_pipeline_success.in0
