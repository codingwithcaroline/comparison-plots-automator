%% File Management
TCrecord=["TC12_Cube", "TC13_Cube", "TC14_Cylinder", "TC15_Cylinder", "TC16_CylinderWithHalfDome", "TC17_Pyramid", "TC18_Diamond", "TC19_Cube", "TC20_RectangularPrism"];
for j=1:numel(TCrecord)
    project1=load(fullfile("C:\Project1_GUI_Testing\Scripts_And_Data\Project1",TCrecord(j),"Project1Results.mat"));
    p1intensity=project1.TotalSignatures;

    project2=load(fullfile("C:\Project1_GUI_Testing\Scripts And Data\Project2",TCrecord(j),"project2_outputs\project2_output.mat"));
    p2intensity=project2.Signatures.Total';

    osc=importdata(fullfile("C:\Project2\Project2_TestCases",TCrecord(j),"osc_inputs\BANDSIGS"),"\t",2);

    %% Comparison plots for project1, project2, and osc.
    figure();
    for i=1:3
        subplot(3,1,i);
        plot(p1intensity(:,i),'b','DisplayName','project1')
        hold on;
        plot(p2intensity(:,i),'r','DisplayName','project2')
        plot(osc.data(:,i+1),'g', 'DisplayName','osc')
        legend();
        ylabel("Intensity");
        xlabel("Time");
        title([TCrecord(j),' Total Signatures-Band ',num2str(i)]);
    end

    savefig(fullfile("C:\Project1_GUI_Testing\ComparePlots",strcat(TCrecord(j),"TotalSignatureCompare.fig")));
    %% Percent Diff Plots Project1 vs. Project2
    figure();
    for i=1:3
        p1=p1intensity(:,i);
        p2=p2intensity(:,i);
        pct_change=100*(p2-p1)./p1;
        subplot(3,1,i);
        yyaxis left
        plot(p1intensity(:,i),'b','DisplayName','project1')
        hold on;
        plot(p2intensity(:,i),'r','DisplayName','project2')
        ylabel("Intensity");
        yyaxis right
        plot(pct_change, 'g', 'DisplayName', '%diff')
        legend();
        xlabel("Time");
        title([TCrecord(j),' Percent Difference Band ',num2str(i)]);
    end
    savefig(fullfile("C:\Project1_GUI_Testing\ComparePlots",strcat(TCrecord(j),"Percent Diff.fig")));
end